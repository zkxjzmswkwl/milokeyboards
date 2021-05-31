import vibe.vibe;

void main()
{
	auto router = new URLRouter;
	router.get( "/", &index );
	router.get ( "*", serveStaticFiles( "public" ) );

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.errorPageHandler = toDelegate( &fourOhFour );

	listenHTTP( ":9090", router );

	runApplication();
}

void index(HTTPServerRequest req, HTTPServerResponse res)
{
	res.render!( "index.dt", req );
}

void fourOhFour(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!( "fourohfour.dt", req );
}