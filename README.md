# Demonstration of error in Ecto for subquery with window function

https://github.com/elixir-ecto/ecto/issues/2281

## Instructions
* `mix deps.get`
* `mix ecto.create`
* `mix test`

Observe the log output and the resulting error:

```
23:17:36.789 [debug] QUERY ERROR source="blog_posts" db=0.9ms
SELECT b0."id", b0."title", b0."body", b0."inserted_at", b0."updated_at" FROM "blog_posts" AS b0 INNER JOIN (SELECT b0."id" AS "id", row_number() OVER (PARTITION BY b0."user_id" ORDER BY b0."updated_at" DESC) AS "row_number" FROM "blog_posts" AS b0) AS s1 ON s1."id" = b0."id" WHERE (s1."row_number" = 1) LIMIT 8 []


  1) test newest_for_frontpage/2 does not raise an error (MyApp.BlogPostTest)
     test/blog_post_test.exs:14
     ** (Postgrex.Error) ERROR 42601 (syntax_error): syntax error at or near "."
     code: |> Repo.all
     stacktrace:
       (ecto) lib/ecto/adapters/sql.ex:431: Ecto.Adapters.SQL.execute_and_cache/7
       (ecto) lib/ecto/repo/queryable.ex:133: Ecto.Repo.Queryable.execute/5
       (ecto) lib/ecto/repo/queryable.ex:37: Ecto.Repo.Queryable.all/4
       test/blog_post_test.exs:16: (test)
```
