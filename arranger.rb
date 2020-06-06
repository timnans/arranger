# frozen_string_literal: true

# class Arranger
class Arranger
  require 'fileutils'
  FOLDERS = %w[Video Audio Document Images].freeze
  def create_folders_not_existing
    FOLDERS.each do |folder|
      if Dir.exist?(folder)
        puts "#{folder} already exists"
      else
        Dir.mkdir(folder)
      end
    end
  end

  def move_images
    images = Dir.glob('*.{jpg,jpeg,png}')
    images.each do |image|
      if check_if_file_exist_in_path?(image, './Images')
        rename_file(image)
        move_images
        break
      else
        FileUtils.mv(image, './Images')
      end
      puts "Moved #{image} to Images"
    end
  end

  def move_video
    videos = Dir.glob('*.{mp4,avi,mkv}')
    videos.each do |video|
      if check_if_file_exist_in_path?(video, './Video')
        rename_file(video)
        move_video
        break
      else
        FileUtils.mv(video, './Video')
      end
      puts "Moved #{video} to Video"
    end
  end

  def move_document
    documents = Dir.glob('*.{docx,csv,pdf,PDF,epub,gif,pptx,xlsx}')
    documents.each do |document|
      if check_if_file_exist_in_path?(document, './Document')
        rename_file(document)
        move_document
        break
      else
        FileUtils.mv(document, './Document')
      end
      puts "Moved #{document} to Document"
    end
  end

  def move_audio
    audios = Dir.glob('*.{mp3}')
    audios.each do |audio|
      if check_if_file_exist_in_path?(audio, './Audio')
        rename_file(audio)
        move_audio
        break
      else
        FileUtils.mv(audio, './Audio')
      end
      puts "Moved #{audio} to Audio"
    end
  end

  def check_if_file_exist_in_path?(file, path)
    FileUtils.cd(path)
    if File.exist?(file)
      FileUtils.cd('../')
      true
    else
      FileUtils.cd('../')
      false
    end
  end

  def rename_file(file)
    puts file_extension = File.extname(file)
    puts file_name = File.basename(file, file_extension)
    File.rename(file, file_name + Time.now.to_s + file_extension)
  end

  def call_all_move_methods
    move_audio
    move_document
    move_images
    move_video
  end
end

arranger = Arranger.new
arranger.create_folders_not_existing
loop do
  arranger.call_all_move_methods
end
