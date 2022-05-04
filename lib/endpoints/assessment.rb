module Wonde
  class Assessment < Endpoints
    attr_accessor :uri, :templates, :aspects, :marksheets, :results, :resultsets

    def initialize(token, id = false, domain:)
      super
      self.templates = Templates.new(token, uri, domain: domain)
      self.aspects = Aspects.new(token, uri, domain: domain)
      self.marksheets = MarkSheets.new(token, uri, domain: domain)
      self.results = Results.new(token, uri, domain: domain)
      self.resultsets = ResultSets.new(token, uri, domain: domain)
    end
  end
end
