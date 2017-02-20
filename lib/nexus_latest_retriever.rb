require "nexus_latest_retriever/version"

module NexusLatestRetriever

  def self.retrieve(opts)
    actual_port = opts[:port] == 80 ? '' : ":#{opts[:port]}"
    common_url = "#{opts[:scheme]}://#{opts[:host]}#{actual_port}/repository/#{opts[:repository]}/#{opts[:group_id].gsub('.','/')}/#{opts[:artifact_id].gsub('.', '/')}"

    if opts[:verbose]
      puts "nexus: #{opts[:scheme]}://#{opts[:host]}#{actual_port}"
      puts "repository: #{opts[:repository]}"
      puts "groupId: #{opts[:group_id]}"
      puts "artifactId: #{opts[:artifact_id]}"
      puts "classifier: #{opts[:classifier] || '<none>'}"
      puts "extension: #{opts[:extension]}"
      puts
    end

    url = common_url + "/maven-metadata.xml"

    puts "Opening url: #{url}" if opts[:verbose]
    meta = Nokogiri::XML(open(url))
    release = false

    release_version = meta.at_xpath("/metadata/versioning/release/text()")

    if release_version
      release = true
      versions = [release_version.to_s]
      puts "Release version detected" if opts[:verbose]
    else
      versions = meta.xpath("/metadata/versioning/latest/text()").to_a.concat(meta.xpath("/metadata/versioning/versions/version/text()").to_a).map {|v| v.to_s}.sort
      if versions.empty?
        puts "No version found in:\n#{meta}";exit 1
      end
    end

    if release
      path = versions.last
    else
      url = "#{common_url}/#{versions.last}/maven-metadata.xml"

      puts "Opening url: #{url}" if opts[:verbose]
      meta = Nokogiri::XML(open(url))

      xpath = "/metadata/versioning/snapshotVersions/snapshotVersion[./extension/text()='#{opts[:extension]}'"
      xpath += " and ./classifier/text()='#{opts[:classifier]}'" if opts[:classifier]
      xpath += ']/value/text()'

      path = meta.at_xpath(xpath)
      unless path
        puts "No version found in:\n#{meta}";exit 1
      end
    end

    puts "Using version: #{path}" if opts[:verbose]

    filename = "#{opts[:artifact_id].gsub('.', '/')}-#{path}"
    filename += "-#{opts[:classifier]}" if opts[:classifier]
    filename += ".#{opts[:extension]}"

    output = opts[:output] || "#{filename}"

    url = "#{common_url}/#{versions.last}/#{filename}"
    puts "Opening url: #{url}" if opts[:verbose]

    begin
      File.open(output, "wb") do |file|
        puts "Saving artifact to: #{output}"
        file.write open(url).read
      end
    rescue => e
      File.delete(output) if File.exist?(output)
      raise e
    end
  end
end
