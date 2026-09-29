The `session` cookie that stores the name can be decoded with the following:
```
(async (fullCookie) => {
  // Extract the part between the first and second dot
  const parts = fullCookie.split('.');
  const raw = parts[0] === "" ? parts[1] : parts[0];
  
  // Add base64 padding if needed
  const padded = raw + "=".repeat((4 - (raw.length % 4)) % 4);
  const b64 = padded.replace(/-/g, '+').replace(/_/g, '/');
  
  const bytes = Uint8Array.from(atob(b64), c => c.charCodeAt(0));
  const stream = new Response(bytes).body.pipeThrough(new DecompressionStream('deflate'));
  const text = await new Response(stream).text();
  console.log(JSON.parse(text));
})(
  // PASTE FULL COOKIE HERE (e.g. .eJw...xyz.aruWVA.Hu5kO0...):
  ".PASTE_YOUR_FULL_COOKIE_HERE"
);
```

Deploying with Docker
```
docker build -t python-docker . &&  docker run -d -p 5000:5000 --name my-flask-app python-docker
docker stop my-flask-app && docker rm my-flask-app
```