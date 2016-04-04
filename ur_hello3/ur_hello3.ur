fun handler r = return <xml><body>
      <h1>Hello {[r.A]} !</h1>
      <a link={main ()}>Come back to the home</a>
    </body>
  </xml>

and main () = return <xml>
	<head><title>Hello world !</title></head>
	<body>
		<h1>Say hello to : </h1>
    <form>
      <textbox{#A} value="World"/>
      <submit action={handler}/>
    </form>
	</body>
</xml>
