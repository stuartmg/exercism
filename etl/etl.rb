class ETL

  def self.transform(old)
    old.each_with_object({}) do |(k,v),results|
      v.each { |v| results[v.downcase] = k }
    end
  end

end
