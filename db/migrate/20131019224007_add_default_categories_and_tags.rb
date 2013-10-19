class AddDefaultCategoriesAndTags < ActiveRecord::Migration
  MIGRATION_ENABLED = true
  @categories = {
      :kebab => [:kebab],
      :pizza => [:pizza],
      :burger => [:burger],
      :other => [:fastfood]
  }

  def self.up
    if MIGRATION_ENABLED
      @categories.each do |category, tags|
        Category.create!(
            name: category.to_s,
            tags: tags.map(&:to_s).join(',')
        )
      end
    end
  end

  def self.down
    @categories.keys.each do |category|
      Category.find_by_name(category.to_s).try(:destroy)
    end
  end
end
