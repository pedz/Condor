class SrcFile
  def self.find(options)
    lines = []
    string = "/usr/contrib/bin/File \
                -extract #{options[:path]} \
                -release #{options[:release]} \
                -version #{options[:version]} \
                -become pedzan \
                -stdout"
    puts(string)
    IO.popen(string) do |io|
      lines = io.readlines
    end
    lines
  end
end
