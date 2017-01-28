program decay
!Radioactive decay calculator
real :: halfLife, amount, time, dec, initAmount

write (*,*) 'Please input the halfLife, amount and time'
read (*,*) halfLife,amount,time
dec = log(2.0)
dec = dec/halfLife

initAmount = exp(dec * time)
initAmount = initAmount * amount

write (*,*) 'Answer', initAmount
end