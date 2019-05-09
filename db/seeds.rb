# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@admin.com', name: 'Admin', surname: 'Admin', password: '12341234', password_confirmation: '12341234')

l1 = Lesson.create(adi: "Bilgisayar Organizasyonu", ders_kodu: "BMU333", sinif: 3, teorik_saat: 3, uygulama_saati: 0, akts: 5)
Lesson.create(adi: "Sayısal Yöntemler", ders_kodu: "BMU222", sinif: 2, teorik_saat: 3, uygulama_saati: 0, akts: 5)


s = Student.create(name: "Alperen", surname: "bozkurt", number: 15260087)
s.lessons << l1
