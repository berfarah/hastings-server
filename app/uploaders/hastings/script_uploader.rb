module Hastings
  # Carrierwave uploader
  class ScriptUploader < CarrierWave::Uploader::Base
    # Choose what kind of storage to use for this uploader:
    storage :file

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/scripts/#{model.id}"
    end

    # Scripts we're accounting for
    def extension_white_list
      %w(rb sh).freeze
    end
  end
end
