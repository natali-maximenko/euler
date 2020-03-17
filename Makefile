.PHONY: start migrate server default lint format test

default: format lint test

start: migrate server

migrate:
	mix ecto.migrate

server:
	iex -S mix phx.server

lint:
	mix credo --strict

format:
	mix format

test:
	mix test
