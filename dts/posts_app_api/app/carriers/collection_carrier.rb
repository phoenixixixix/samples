# frozen_string_literal: true

class CollectionCarrier < SimpleDelegator
  def initialize(scope, data_wrapper:)
    super(scope)
    @data_wrapper = data_wrapper
  end

  def data
    @data_wrapper.call(self)
  end

  private

  def collection
    __getobj__
  end
end
