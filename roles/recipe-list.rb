# Name of the role should match the name of the file
name "recipe-list"

# Run list function we mentioned earlier
run_list(
    "recipe[main]",
    "recipe[apache2]",
    "recipe[mysql]",
    "recipe[postgres]",
    "recipe[php5]",
    "recipe[python-env]",
)