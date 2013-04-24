module("View User Measurement History");

test('Test Get Measurement History', function()
{
    strictEqual(getMeasurementHistory("Shaw", "weight"), 0);
});
