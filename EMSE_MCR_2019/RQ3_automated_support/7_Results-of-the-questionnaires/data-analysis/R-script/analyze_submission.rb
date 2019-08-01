#!/usr/bin/ruby

require 'levenshtein'

# removes comments and whitespaces to ease comparison
def normalizeFileContents(file)
  transformed_lines = Array.new
  file.each_line do |line|
    # remove comments
    line = line.gsub(/\/\/(.*)$/, '')
    # remove classname
    line = line.gsub(/class (\w*)/, 'class')
    line.strip!
    unless line.empty?
      transformed_lines << line
    end
  end
  transformed_lines.join("\n")
end

def analyze(file)
  return [file.scan(/@Test/).size, file.scan(/assert/).size + file.scan(/catch/).size]
end

modifiedFileName = ARGV[0]
originalFileName = modifiedFileName.sub('.java', '') + '_original' + '.java'

modifiedFile = normalizeFileContents File.read(modifiedFileName)
originalFile = normalizeFileContents File.read(originalFileName)

resModified = analyze modifiedFile
resOriginal = analyze originalFile

resDiff = resModified.zip(resOriginal).map { |a,b| a-b}
dist = Levenshtein.distance(modifiedFile, originalFile)

output = [modifiedFileName.to_s, resDiff.join(','), dist].join(',')
puts output