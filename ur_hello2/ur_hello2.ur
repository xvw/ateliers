fun hello nickname = return <xml>
	<head><title>Say Hello to {[nickname]}! </title></head>
	<body>
    <h1>Hello {[nickname]}</h1>
	</body>
</xml>

fun main () = return <xml>
	<head><title>Say Hello ! </title></head>
	<body>
    <ul>
      <li><a link={hello "Nuki"}>Hello to Nuki</a></li>
      <li><a link={hello "FalconPilot"}>Hello to FalconPilot</a></li>
    </ul>
	</body>
</xml>
