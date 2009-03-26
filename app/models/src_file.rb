class SrcFile
  def self.find(options)
    lines = []
    string = "/usr/local/cmvc/bin/File \
                -extract #{options[:path]} \
                -release #{options[:release]} \
                -version #{options[:version]} \
                -family aix \
                -become pedzan \
                -stdout"
    puts(string)
    IO.popen(string) do |io|
      lines = io.readlines
    end
    lines
  end
end
