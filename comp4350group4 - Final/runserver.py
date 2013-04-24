import sys
from lumberjack import app
if (len(sys.argv) > 1 and sys.argv[1] == "d"):
    app.debug = True
app.run(host='0.0.0.0')
