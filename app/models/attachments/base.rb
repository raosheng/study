# -*- encoding : utf-8 -*-

class Attachments::Base < ActiveRecord::Base

  self.table_name = 'assets'

  belongs_to :assetable, :polymorphic => true

  validates :data, :presence => true

  after_initialize :generate_access_token

  before_save :update_asset_attributes
  before_update :update_asset_attributes

  scope :find_by_assetable, ->(type, id) { where(assetable_type: type, assetable_id: id) }

  def set_assetable!(type, id)
    self.assetable_type = type
    self.assetable_id = id
  end

  protected

  def update_asset_attributes
    self.content_type ||= data.file.content_type
  end

  def generate_access_token
    self.access_token = SecureRandom.uuid.gsub("-","")
  end

end
