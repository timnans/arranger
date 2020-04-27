class Arranger
    require "fileutils"
    FOLDERS = ["Video", "Audio", "Document", "Images"]
    
    def create_folders_not_existing
        
        FOLDERS.each do |folder|
            unless Dir.exist?(folder)
                Dir.mkdir(folder)
            else
                puts "#{folder} already exists"
            end
        end
    
    end


    def move_images
    images = Dir.glob("*.{jpg,jpeg}")
     images.each do  |image|
        if check_if_file_exist_in_path?(image, './Images') 
        rename_file(image)
        move_images
        break
            FileUtils.mv(image, './Images')
            puts "Moved #{image} to Images"
        else
            FileUtils.mv(image, './Images')
            puts "Moved #{image} to Images"



        end
        # FileUtils.mv(image, './Images')
         
     end
    end

    def move_video
        video = Dir.glob("*.{mp4,avi}")
        
        video.each do  |video|
            if check_if_file_exist_in_path?(video, './Video') 
                rename_file(video)
                move_video
                break
                FileUtils.mv(video, './Video')
                puts "Moved #{video} to Video"
            else
                FileUtils.mv(video, './Video')
                puts "Moved #{video} to Video"
          
            
            end
        #    FileUtils.mv(video, './Video')
        #    puts "Moved #{video} to Video"

        end
    end

    def move_document
        document = Dir.glob("*.{docx,csv,pdf}")
        document.each do  |document|
           if check_if_file_exist_in_path?(document, './Document')
               rename_file(document)
               move_document
               break
             
              FileUtils.mv(document, './Document')
              puts "Moved #{document} to Document"

           else
            FileUtils.mv(document, './Document')
            puts "Moved #{document} to Document"
            
           end
        #    FileUtils.mv(document, './Document')
        #    puts "Moved #{document} to Document"
        end
    end

    def move_audio
        audio = Dir.glob("*.{mp3}")
        audio.each do  |audio|
            if check_if_file_exist_in_path?(audio, './Audio') 
            rename_file(audio)
            move_audio
            break

            FileUtils.mv(audio, './Audio')
           puts "Moved #{audio} to Audio"
            else

            FileUtils.mv(audio, './Audio')
           puts "Moved #{audio} to Audio"
            end
           

        end
    end

    def check_if_file_exist_in_path?(file, path)
        FileUtils.cd(path)
         if File.exist?(file) 
            FileUtils.cd("../")
            true
         else
            FileUtils.cd("../")
               false
        end
    
    end

    def rename_file(file)
        puts file_extension = File.extname(file)
       puts file_name = File.basename(file, file_extension) 
       File.rename(file, file_name + Time.now.to_s + file_extension)
        # puts "file has been renamed to #{x}"
        # puts "#{file}"

    end

    def call_all_move_methods
    move_audio
    move_document
    move_images
    move_video

    end
end

arranger = Arranger.new
# arranger.check_if_file_exist_in_path("firehouse.jpg", './')
arranger.create_folders_not_existing

while true
    # arranger.move_document
    arranger.call_all_move_methods  
end

    

