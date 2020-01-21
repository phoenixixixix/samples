# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end