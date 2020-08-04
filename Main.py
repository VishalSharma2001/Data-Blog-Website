from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
from flask_mail import  Mail
import json
import os
import math


with open('config.json','r') as c:
    params=json.load(c)["params"]
local_server=True

app=Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.secret_key="Flask_Website"
app.config['UPLOAD_FOLDER']=params['upload_location']
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-pass']
)
mail=Mail(app)
if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)
 
class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(120),  nullable=False)
    msg = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    email = db.Column(db.String(20),  nullable=False)

class posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tag_line = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(120),  nullable=False)
    content = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    img_file = db.Column(db.String(12),  nullable=True)
    writer = db.Column(db.String(22),  nullable=True)


@app.route('/')
def home():
    post = posts.query.filter_by().order_by(posts.sno.desc()).all()
    last=math.ceil(len(post)/int(params['no_of_post']))
    #post=posts.query.filter_by().all()[0:params['no of post']]
    page=request.args.get('page')
    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    post = post[(page-1)*int(params['no_of_post']):(page-1)*int(params['no_of_post'])+int(params['no_of_post'])]

    if (page==1):
        prev='#'
        next="/?page="+str(page+1)
    elif(page==last):
        next='#'
        prev="/?page="+str(page-1)
    else:
        next="/?page="+str(page+1)
        prev="/?page="+str(page-1)
    return (render_template('index.html',params=params,post=post,prev=prev,next=next))


@app.route('/about')
def about():
    return (render_template('about.html',params=params))

@app.route('/dashboard',methods=['GET','POST'])
def dashboard():
    if ('user' in session and session['user']==params['admin_user']):
        post = posts.query.all()
        return  render_template('dashboard.html',params=params,post=post)


    if request.method=='POST':
        username=request.form.get('uname')
        password=request.form.get('pass')
        if (username==params['admin_user'] and password==params['admin_password']):
            session['user']=username
            post=posts.query.all()
            return render_template("dashboard.html",params=params,post=post)

    return (render_template('login.html',params=params))

@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    post=posts.query.filter_by(slug=post_slug).first()

    return (render_template('post.html',params=params,post=post))

@app.route("/edit/<string:sno>",methods=['GET','POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method=='POST':
            box_title=request.form.get('title')
            tline=request.form.get('tline')
            slug=request.form.get('slug')
            content=request.form.get('content')
            writer=request.form.get('writer')
            img_file=request.form.get('img_file')
            date=datetime.now()


            if sno=='0':
                post=posts(title=box_title,tag_line=tline,slug=slug,content=content,img_file=img_file,writer=writer,date=date)
                db.session.add(post)
                db.session.commit()

            else:
                post=posts.query.filter_by(sno=sno).first()
                post.title=box_title
                post.slug=slug
                post.tag_line=tline
                post.img_file=img_file
                post.writer=writer
                post.date=date
                db.session.commit()
                return redirect('/edit/'+sno)
        post=posts.query.filter_by(sno=sno).first()
        return render_template('edit.html',params=params,post=post,sno=sno)

@app.route("/delete/<string:sno>",methods=['GET','POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post=posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route('/uploader',methods=['GET','POST'])
def upload():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method=="POST"):
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            #return "Uploaded Successfully"
            return redirect('/dashboard')

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route('/contact',methods=['GET','POST'])
def contect():
    if (request.method=="POST"):
          
           name=request.form.get('name')
           email=request.form.get('email')
           phone=request.form.get('phone')
           messege=request.form.get('messege')

           entry=Contacts(name=name,email=email,phone_num=phone,date=datetime.now(),msg=messege)     
           db.session.add(entry)
           db.session.commit()

           mail.send_message(
                        "New Messege from:"+name,
                         sender=email,
                         recipients=[params['gmail-user']],
                         body=messege +'\n'+phone
           )

    return (render_template('contact.html',params=params))

if __name__ == "__main__":
    app.run(debug=True)
