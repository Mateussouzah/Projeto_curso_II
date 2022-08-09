usethis::use_git_config(user.name = "Mateussouzah",
                        user.mail = "mateussouzah@gmail.com")
usethis::use_git()


usethis::create_github_token()

gitcreds::gitcreds_set()

usethis::use_github()
