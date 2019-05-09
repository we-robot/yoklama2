class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :adi
      t.string :ders_kodu
      t.integer :sinif
      t.integer :teorik_saat
      t.integer :uygulama_saati
      t.integer :akts

      t.timestamps
    end
  end
end
