# frozen_string_literal: true

ActiveRecord::Base.transaction do
  Dir[Rails.root.join('db/seeds/*.rb')].sort.each { |seed| load seed }
end
