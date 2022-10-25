import torch.nn as nn
import torch
func=nn.CrossEntropyLoss()



a=torch.Tensor([-0.0341, -0.0504, -0.0303, -0.1261, -0.0864, -0.0164, -0.0630,  0.0871,
                -0.1021,  0.0734,  0.0230, -0.0892,  0.0299, -0.0138,  0.0432,  0.0600,
         0.0041, -0.0632, -0.0650,  0.0388])
fuc2=nn.LogSoftmax(dim=1)
b=a.reshape(-1,1)
ret=fuc2(a)
print(ret)
# a=a.unsqueeze(0)
# b=torch.tensor([3.0])
# print(b.shape)
# print(b)
#
# b=torch.Tensor(b)
# loss=func(a,b.
# print("总loss:",loss)
