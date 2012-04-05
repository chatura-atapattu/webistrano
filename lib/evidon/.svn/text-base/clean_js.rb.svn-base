module Evidon
  
  module CleanJS
    
    # remove a function declaration and return the new string
    def self.remove(str, name)
      a = str.index(name)
      return str if a.nil?
      b = str[a..str.length].index("};") + a + 1
      str[0..a-1] + str[b+1..str.length]
    end

    def self.cleanup(filename)
      output = []
      output << "var _w = window;"
      skip_next = false

      File.new(filename).readlines.each { |line|

        line.strip!

        # see if we should skip (exclude) a line
        next if line.empty?

        if skip_next then
          skip_next = false if line.include? "*/"
        next
        end

        # insert mass shorteners
        if line =~ %r{\/\/ mass shorteners} then
          line = "_w=window,_d=document,_e=encodeURIComponent,_o=BAP.options,_n=null,_st=setTimeout,_pi=parseInt,_pf=parseFloat,_tech_ticker=(location.href.indexOf('tech-ticker') >= 0),_l='length',"
        output << line
        next
        end

        next if line =~ %r{^//}

        if line =~ %r{^/\*} then
          next if line.include? "*/"
        skip_next = true
        next
        end

        next if line.include? "NON_PROD"

        # skipping trace calls: BAPUtil.trace("BAP Current Trace (%s)", bap);
        # custom for BAP, specifically ba.js
        next if line.include? "BAPUtil.trace"

        # CLEANUP

        # remove inline // style comments
        line = line[0..line.index(" //")] if line.include? " //"

        # remove call to cleaned up method
        line.gsub!(/ else \{ BAPUtil.css\(reg\); \}/, '')

        # VARIABLE SUBSTITUTION
        line.gsub!(/document\./, "_d.")
        line.gsub!(/window\./, "_w.")
        line.gsub!(/encodeURIComponent\./, "_e.")
        line.gsub!(/BAP\.options/, "_o")
        line.gsub!(/null/, "_n")
        line.gsub!(/setTimeout/, "_st")
        line.gsub!(/parseInt/, "_pi")
        line.gsub!(/parseFloat/, "_pf")
        line.gsub!(/\.length/, "[_l]")
        line.gsub!(/location\.href\.indexOf\('tech\-ticker'\) >= 0/, "_tech_ticker")

        output << line
      }

      js = output.join("\n")

      # do some final cleanup
      # js = remove(js, "var BAPUtil = {")
      # js = remove(js, "this.toString = function() {")

      o = js.split("\n")
      o.delete_if{|s| s.strip.empty? }

      return o.join("\n")
    end

  end # module CleanJS

end # module Evidon

if File.basename($0) == "clean_js.rb" then
  filename = ARGV[0]
  env = ARGV[1]

  if not filename then
    puts "usage: clean_js.rb <filename>"
    exit
  end

  if not File.exists? filename then
    puts "input file #{filename} not found!"
    exit 0
  end

  print Evidon::CleanJS.cleanup(filename)
end
