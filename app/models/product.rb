class Product < ActiveRecord::Base
  include Elasticsearch::Model
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
 
 def as_indexed_json
   self.as_json({
    only: [:title, :description],
    include: {
      category: { only: :name },
    
    }
  })
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

# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
if line_items.empty?
return true
else
errors.add(:base, 'Line Items present')
return false
end
end
end
