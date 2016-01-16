class PublicResource < ActiveRecord::Base

  has_many :attachments, :as => :attachmentable
  accepts_nested_attributes_for :attachments, :reject_if => lambda { |item| item[:file].blank? }, :allow_destroy => true
end
