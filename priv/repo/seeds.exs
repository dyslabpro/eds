# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eds.Repo.insert!(%Eds.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query
import Eds.Factory
require Logger

alias Eds.Repo
alias Eds.Core.{Course, Chapter, Section, Category}
alias Eds.Accounts.{User, UserCourse}

Eds.Repo.delete_all(Eds.Core.CourseCategory)
Eds.Repo.delete_all(Eds.Content.Text)
Eds.Repo.delete_all(Eds.Content.Image)
Eds.Repo.delete_all(Eds.Content.Node)

Eds.Repo.delete_all(Eds.Core.Category)
Eds.Repo.delete_all(Eds.Core.Section)
Eds.Repo.delete_all(Eds.Core.Chapter)

Eds.Repo.delete_all(Eds.Accounts.UserCourse)
Eds.Repo.delete_all(Eds.Accounts.User)
Eds.Repo.delete_all(Eds.Core.Course)

# Users
admin =
  Repo.insert!(%User{
    name: "Admin Adminovish",
    email: "admin@example.com",
    handle: "dyslabpro",
    admin: true
  })

admin2 =
  Repo.insert!(%User{
    name: "Admin2 Adminovish2",
    email: "admin2@example.com",
    handle: "dyslabpro2",
    admin: true
  })

admin3 =
  Repo.insert!(%User{
    name: "Admin3 Adminovish3",
    email: "admin3@example.com",
    handle: "dyslabpro3",
    admin: true
  })

admins = [admin, admin2, admin3]
categories = insert_list(12, :category)
courses = insert_list(10, :course)
admins = insert_list(15, :admin)
students = insert_list(15, :student)
course_categories = insert_list(200, :course_categories)
user_course = insert_list(200, :user_course)
images = insert_list(200, :image)

images = Eds.Repo.all(Eds.Content.Image)

# Enum.each(images, fn image ->
#   url = "http://placeimg.com/640/360/any"
#   file_name = "test.jpg"
#   file_body = Eds.Tools.download(url)

#   if file_body do
#     File.write!("/tmp/#{file_name}", file_body)

#     image_params = %{
#       title: image.title,
#       weight: image.weight,
#       image: %Plug.Upload{
#         content_type: "image/jpg",
#         filename: file_name,
#         path: "/tmp/#{file_name}"
#       }
#     }

#     Eds.Content.Image.image_changeset(image, image_params) |> Repo.update()
#     File.rm!("/tmp/#{file_name}")
#   end
# end)


