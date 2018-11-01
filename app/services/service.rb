class Service
  class << self
    def execute(*opts)
      perform(*opts)
    end
  end
end
