# frozen_string_literal: true

ActiveAdmin.register Genre do
  permit_params :name, :slug

  controller do
    defaults finder: :find_by_slug
  end
end
