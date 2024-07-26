require 'memory_profiler'

class NewClass
  def self.allot
    a = Array.new
    a = [1,2,3,4]
  end
end



report = MemoryProfiler.report do
  NewClass.allot
end

report.pretty_print(to_file: "report.txt")