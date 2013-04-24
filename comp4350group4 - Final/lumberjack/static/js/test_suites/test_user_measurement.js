module("Add User Measurement");

test('Test save_measurement', function()
{
    strictEqual(save_measurement("Shaw", "http://www.gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e?d=mm&amp;s=40", true), 0);
});
