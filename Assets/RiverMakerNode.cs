using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class RiverMakerNode : MonoBehaviour
{
    [SerializeField] RiverMaker riverMaker;
    [SerializeField] private float riverWidth = 1;

    public float RiverWidth
    {
        get => riverWidth;
        set
        {
            riverWidth = value;
            riverMaker.DrawRiver();
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawSphere(transform.position, 1);
    }
    private void Awake()
    {
        if (transform.parent == null || transform.parent.name != "Control Points" || transform.GetComponentInParent<RiverMaker>() == null)
        {
            Debug.LogError("RiverMaker Control Node must a child of RiverMaker's child Control Points");
            DestroyImmediate(this);
        }
        riverMaker = transform.GetComponentInParent<RiverMaker>();
        if (!riverMaker.controlPointList.Contains(this))
            riverMaker.controlPointList.Add(this);
    }

    private void Update()
    {
        if (transform.hasChanged)
        {
            transform.GetComponentInParent<RiverMaker>().DrawRiver();
            transform.hasChanged = false;
        }
    }

    void OnDestroy()
    {
        riverMaker.controlPointList.Remove(this);
        riverMaker.DrawRiver();
    }

    void OnValidate()
    {
        riverMaker.DrawRiver();
    }


}