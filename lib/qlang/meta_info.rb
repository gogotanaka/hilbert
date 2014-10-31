# $meta_info indicate what and how to do.

class MetaInfo
  include Singleton
  attr_accessor :lang, :opts, :mode

  def _load
    # compiles into R as default.
    lang = :r
  end

  # TODO: YAML.load_file("./lib/qlang/utils/langs.yml")['langs']
  def langs_hash
    {
      r:"R",
      ruby: "Ruby",
      python: "Pyhton",
      haskell: "Haskell",
      scala: "Scala",
      js: "Javascript"
    }
  end

  def lang_str
    LANGS_HASH[@lang.to_s]
  end
end
