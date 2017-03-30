FactoryGirl.define do
  factory :attachment do
    file File.new("#{Rails.root}/spec/files/file.jpg")
  end
end