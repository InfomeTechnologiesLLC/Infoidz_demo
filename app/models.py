from django.db import models

# Create your models here.
class cards(models.Model):
    """
    This model represents the view card styles
    """
    name=models.CharField(max_length=50)
    temp_image=models.ImageField(upload_to='card/template',null=True)
    active=models.BooleanField(default=True)
    
    def __str__(self):
        return self.name
    
    class Meta:
        db_table='cards'

