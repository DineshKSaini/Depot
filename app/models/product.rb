require 'elasticsearch/model'
class Product < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:
          %r{\.(gif|jpg|png)$}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }

  has_many :line_items
  has_many :orders, through: :line_items
  #a product should belong to a category
  belongs_to :category
  has_many :reviews
  before_destroy :ensure_not_referenced_by_any_line_item

  #below callbcaks use for $redis
  after_create :redis_push
  after_update :redis_update
  after_destroy :redis_update
  #after_save    :update_index#Product.__elasticsearch__.create_index! force: true #{ logger.debug ["Updating document... ", __elasticsearch__.index_document ].join }
  #after_destroy  :update_index #{ logger.debug ["Deleting document... ", __elasticsearch__.delete_document].join }
  after_commit :delete_product, on: :destroy
  after_commit :index_product, on: :create

  mapping do
    indexes :title
    indexes :id, type: "integer"
    indexes :description
    indexes :category , type: 'nested' do
    indexes :name
    end 
  end

  #update elastic search index
  def delete_product
      self.__elasticsearch__.delete_document
  end

  def index_product
    product = self
    product.reload
    product.__elasticsearch__.index_document
  end
  
#Product.first.update_attribute :title, 'Updated!'

  def as_indexed_json(options = {})
   json = {
      id: id,
      title: title,
      description: description,
      category: category.as_json({only: [:name]}),
   }
  end


  def self.import
    Product.includes(:category).find_in_batches do |products|
      bulk_index(products)
    end
  end

  def self.prepare_records(products)
    products.map do |product|
      { index: { _id: product.id, data: product.as_indexed_json } }
    end
  end

  def self.bulk_index(products)
    Product.__elasticsearch__.client.bulk({
      index: ::Product.__elasticsearch__.index_name,
      type: ::Product.__elasticsearch__.document_type,
      body: prepare_records(products)
    })
  end

  private
#update redis  record using side key
  def redis_update
    #binding.pry
    #$redis.LTRIM('products',0,-$redis.LLEN('products'))
    $redis.DEL('products')
    Product.all.each{|p| $redis.LPUSH("products", p.to_json)}
    $redis.LRANGE('products',0,-1)
  end

  def self.redis_get
    products = $redis.LRANGE('products',0,-1)
    #binding.pry
    products = redis_update if products.blank?
    #binding.pry
    products.map{|p| JSON.parse(p)}
  end

  # def redis_pop
  #   $redis.LPOP('products',)
  # end

  def redis_push()
    #push new product into list
    $redis.LPUSH('products',self.to_json)
  end


# ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    #binding.pry
    if line_items.empty?
    return true
    else
    errors.add(:base, 'Line Items present')
    return false
  end
end
end
