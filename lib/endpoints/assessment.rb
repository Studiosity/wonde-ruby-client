module Wonde
  class Assessment < Endpoints
    attr_accessor :uri, :templates, :aspects, :marksheets, :results, :resultsets
    def initialize(token, id=false, domain:)
      super
      self.templates = Templates.new(token, self.uri, domain: domain)
      self.aspects = Aspects.new(token, self.uri, domain: domain)
      self.marksheets = MarkSheets.new(token, self.uri, domain: domain)
      self.results = Results.new(token, self.uri, domain: domain)
      self.resultsets = ResultSets.new(token, self.uri, domain: domain)
    end

  end
end
