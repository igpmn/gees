
z = cell(1, size(this.Gradients, 2));
for i = 1 : size(this.Gradients, 2)
    disp(i)
    tic
    grad = vectorize(this.Gradients{1, i});
    grad = str2func(grad);
    z{i} = grad(data.YXEPG, frameColumns, data.BarYX);
    toc
end
