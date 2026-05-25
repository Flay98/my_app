# Очистка старых данных
ExpertRating.destroy_all
Image.destroy_all
Task.destroy_all
Theme.destroy_all
User.destroy_all

# Создание пользователей
designer = User.create!(
  username: "designer01",
  email: "designer01@example.com",
  first_name: "Иван",
  last_name: "Дизайнер",
  password: "password",
  password_confirmation: "password",
  role: "expert"
)

expert = User.create!(
  username: "expert01",
  email: "expert01@example.com",
  first_name: "Анна",
  last_name: "Эксперт",
  password: "password",
  password_confirmation: "password",
  role: "expert"
)

# Создание тем
mobile_theme = Theme.create!(name: "Mobile App Design", description: "Референсы для экранов мобильных приложений")
landing_theme = Theme.create!(name: "Landing Page Design", description: "Референсы для лендингов и веб-страниц")
branding_theme = Theme.create!(name: "Branding and Visual Identity", description: "Логотипы, фирменный стиль и айдентика")

# Создание задач
mobile_task = Task.create!(user: designer, theme: mobile_theme, title: "Подбор мобильных экранов", description: "Примеры экранов мобильного приложения")
landing_task = Task.create!(user: designer, theme: landing_theme, title: "Подбор веб-референсов", description: "Примеры лендингов и веб-страниц")
branding_task = Task.create!(user: designer, theme: branding_theme, title: "Подбор брендинга", description: "Примеры логотипов и визуального стиля")

# Массив для изображений
images = []

# Mobile картинки
(1..4).each do |i|
  images << { task: mobile_task, file_name: "mobile_#{i}.jpg", description: "Мобильный экран #{i}" }
end

# Web/landing картинки
(1..4).each do |i|
  images << { task: landing_task, file_name: "web_#{i}.jpg", description: "Веб-референс #{i}" }
end

# Branding/Logo картинки
(1..4).each do |i|
  images << { task: branding_task, file_name: "logo_#{i}.jpg", description: "Логотип / айдентика #{i}" }
end

# Создание изображений
created_images = images.map { |attrs| Image.create!(attrs) }

# Присвоение оценок экспертами
created_images.each_with_index do |image, index|
  ExpertRating.create!(
    user: expert,
    image: image,
    rating: 6 + index % 5  # рейтинг от 6 до 10 по циклу
  )
end