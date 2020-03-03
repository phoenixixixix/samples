class Slugged < Module
  def initialize(options = {})
    source = options.delete(:source) || :name

    defaults = {
      presence: true,
      uniqueness: true,
    }

    singleton_class.send(:define_method, :included) do |base|
      base.instance_eval do
        before_validation :set_default_slug

        validates :slug, defaults.merge!(options)
      end
    end

    define_method :set_default_slug do
      self.slug ||= send(source)&.parameterize
    end

    private :set_default_slug

    define_method :to_param do
      slug
    end
  end
end
