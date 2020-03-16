[
  import_deps: [:ecto, :phoenix],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  locals_without_parens: [
    # Ecto

    ## schema
    field: :*,
    belongs_to: :*,
    has_one: :*,
    has_many: :*,
    many_to_many: :*,
    embeds_one: :*,
    embeds_many: :*,

    ## migration
    create: :*,
    create_if_not_exists: :*,
    alter: :*,
    drop: :*,
    drop_if_exists: :*,
    rename: :*,
    add: :*,
    remove: :*,
    modify: :*,
    execute: :*,

    ## query
    from: :*,

    # router
    plug: :*,
    get: :*,
    post: :*,
    pipe_through: :*,
    resources: :*,
    options: :*,
    put: :*,
    delete: :*,

    ## config
    socket: :*,
    transport: :*,

    ## controllers
    action_fallback: :*
  ]
]
