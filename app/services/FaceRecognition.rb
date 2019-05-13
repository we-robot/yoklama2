class FaceRecognition
  def self.identify(image)
    puts image
    system('cp "' + image + '" /tmp/deneme.jpg')

    print `/home/alperen/Desktop/taninma/a.sh &`
    taninmayan = 0
    taninan_kisiler = []
    File.open('/tmp/deneme.txt', "r") do |f|
      f.each_line do |line|
        if line.start_with?('---> ')
          satir = line[5..-2]

          satir = satir.split(', ')
          oran = satir.last[1..-1].to_f

          if oran > 0.5
            taninan_kisiler << satir.first
          else
            taninmayan += 1
          end
        end
      end
    end
    ret = [taninan_kisiler, taninmayan]
    puts ret.to_s
    return ret
  end
end
