defmodule BlogPhoenixWeb.Router do
  use BlogPhoenixWeb, :router
  plug :scrub_params, "comment" when action in [:add_comment]

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
    post = Post |> Repo.get(post_id) |> Repo.preload([:comments])

  if changeset.valid? do
    Repo.insert(changeset)

    conn
    |> put_flash(:info, "Comment added.")
    |> redirect(to: post_path(conn, :show, post))
  else
    render(conn, "show.html", post: post, changeset: changeset)
  end
end  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
  resources "/posts", PostController do
    alias BlogPhoenix.Comment
    post "/comment", PostController, :add_comment
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogPhoenixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BlogPhoenixWeb.Telemetry
    end
  end
end
