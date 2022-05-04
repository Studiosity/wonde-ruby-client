module Wonde
  class ResultIterator < Endpoints
    include Enumerable
    attr_accessor :myarray, :meta, :token

    def initialize(myhashostruct, token, domain:)
      super
      p myhashostruct if ENV['debug_wonde']
      self.token = token
      self.myarray = myhashostruct.data
      self.meta = myhashostruct.meta unless myhashostruct.meta.nil?
    end

    def <<(val)
      @myarray << val
    end

    def length
      count
    end

    def each
      original_length = @myarray.length - 1
      @myarray.each_with_index do |val, index|
        if index >= original_length and meta and meta.pagination.more
          resp = getUrl(meta.pagination.next).body
          nextResponse = JSON.parse(resp, object_class: OpenStruct)
          p nextResponse if ENV['debug_wonde']
          self.meta = nextResponse.meta unless nextResponse.meta.nil?
          nextResponse.data.each do |element|
            @myarray.push(element)
          end
          original_length += nextResponse.data.count
        end
        yield val
      end
    end
  end
end
