from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def top():
    name = "top"
    return render_template('top.html', title='top page', name=name)

@app.route('/hello_world')
def hello_world():
    return 'Hello, World!'

