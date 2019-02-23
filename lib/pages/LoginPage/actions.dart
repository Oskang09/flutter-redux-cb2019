class LoginRequest
{
    String name;
    String password;

    LoginRequest({ this.name, this.password });
}

class LoginSuccess
{
    String message;
    LoginSuccess(this.message);
}

class LoginFail
{
    String error;
    LoginFail(this.error);
}