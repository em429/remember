FactoryBot.define do
  factory :book do
    # Optional cover and epub paths, otherwise book is created
    #  without any attachments
    transient do
      cover_path { }
      epub_path { }
    end

    user
    title { Faker::Book.title }
    author { Faker::Book.author } 
    parag = ""
    (1..23).each do
      parag += Faker::Lorem.paragraph
    end
    plaintext { parag }

    # 'ev' parameter stands for the factorybot 'evaluator'
    # I use it to access transient attributes on the factory.
    after(:build) do |book, ev|
      book.cover.attach(
        io: File.open(ev.cover_path, 'r'),
        filename: File.basename(ev.cover_path),
        content_type: MiniMime.lookup_by_filename(ev.cover_path)
      ) if ev.cover_path
      book.epub.attach(
        io: File.open(ev.epub_path, 'r'),
        filename: File.basename(ev.epub_path),
      ) if ev.epub_path
    end

    trait :without_title do
      title { }
    end

    trait :without_plaintext do
      plaintext { }
    end

    factory :fiction_book do
     fiction { true }
    end

    factory :nonfiction_book do
      fiction { false }
    end

  end

end
