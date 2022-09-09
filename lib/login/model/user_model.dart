bool login(String username, String password) {
  return usersDb[username.toLowerCase().trim()] == password.trim();
}

const usersDb = {
  'alice': 'password',
  'bob': 'password2',
  'admin': 'admin',
};

String getModel() {
  return '''[request_definition]
r = sub, obj, act
[policy_definition]
p = sub, obj, act
[role_definition]
g = _, _
[policy_effect]
e = some(where (p.eft == allow))
[matchers]
m = g(r.sub, p.sub) && r.obj == p.obj && r.act == p.act''';
}

String getPolicy() {
  return '''p,alice,data1,read
p,bob,data2,read
p,admin,data1,read
p,admin,data2,read''';
}
