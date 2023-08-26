import psutil   # cross-platform library for accessing system details and managing processes
from flask import Flask, render_template # function from the flask module.
app = Flask(__name__) # creates a Flask web application instance
@app.route("/") # this decorator defines the route, This route corresponds to the root URL ("/") of the web application.

def utility(): # Within the defined route, there's a function named utility() that calculates the CPU and memory utilization using the psutil module.
    cpu_using = psutil.cpu_percent()
    mem_using = psutil.virtual_memory().percent
    Report = "Under Utilized"
    if cpu_using > 80 and mem_using > 80:
        Report = "!!! Warning !!! CPU and Memory Utilization is high !!! Warning !!!"
    elif cpu_using > 80 and mem_using < 80:
        Report = "!!! Warning !!! CPU Utilization is high !!! Warning !!!"
    elif mem_using > 80 and cpu_using < 80:
        Report = "!!! Warning !!! Memory Utilization is high !!! Warning !!!"
    return render_template("index.html", cpu_using=cpu_using, mem_using=mem_using, report=Report)

if __name__=='__main__':
    app.run(debug=True, host = '0.0.0.0')