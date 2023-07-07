using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMatrix : MonoBehaviour
{
    public GameObject targetCam;

    void Start()
    {
        var worldPos = transform.parent.localToWorldMatrix.MultiplyPoint(this.transform.localPosition);
        Debug.Log(worldPos);


        var targetPos = targetCam.transform.worldToLocalMatrix.MultiplyPoint(worldPos);
        Debug.Log(targetPos);

    }

}
